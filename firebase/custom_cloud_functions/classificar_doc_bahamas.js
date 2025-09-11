exports.classificarDocBahamas = functions.https.onRequest(async (req, res) => {
  if (applyCors(req, res)) return;

  if (req.method === "GET") {
    return res.status(200).json({ ok: true, msg: "classificarDocBahamas up" });
  }
  if (req.method !== "POST") {
    res.set("Allow", "POST,OPTIONS,GET");
    return res.status(405).send("Method Not Allowed");
  }

  try {
    let body = req.body;
    if (typeof body === "string") {
      try {
        body = JSON.parse(body);
      } catch {}
    }
    const data = body && typeof body === "object" ? (body.data ?? body) : {};

    const img = data?.image;
    const minConfidence =
      typeof data?.minConfidence === "number" ? data.minConfidence : 0.7;
    const model = data?.model || "gemini-1.5-pro"; // pode usar "gemini-1.5-flash" p/ custo/latência

    if (!looksLikeImageRef(img)) {
      return res.status(400).json({
        ok: false,
        errors: [
          "Campo 'image' ausente ou inválido. Envie https, dataURL, gs://, {base64,mimeType}, {inlineData}, ou {bytes,mimeType}.",
        ],
      });
    }

    // ⚠️ Use env/config, não hardcode:
    const apiKey = "AIzaSyCxq0iBKdwc2F7SdBnYCzMhC-nXIMIEyyU" || "";

    if (!apiKey) {
      return res
        .status(500)
        .json({ ok: false, errors: ["GEMINI_API_KEY não configurada."] });
    }

    const out = await classifySingleImage(img, apiKey, model);

    const isBahamasDoc =
      out.type !== "other" && out.countryLikely === "Bahamas";
    const meetsConfidence = out.confidence >= minConfidence;
    const accepted = isBahamasDoc && meetsConfidence;

    const http = accepted ? 200 : 422;

    return res.status(http).json({
      ok: accepted, // sucesso de negócio
      accepted, // explícito
      minConfidence, // parâmetro de corte usado
      result: out, // payload completo do classificador
    });
  } catch (e) {
    console.error(e);
    return res
      .status(500)
      .json({
        ok: false,
        errors: [`Falha ao classificar: ${e.message || String(e)}`],
      });
  }
});
