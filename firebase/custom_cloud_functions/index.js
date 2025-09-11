const admin = require("firebase-admin/app");
admin.initializeApp();

const verificarDocumentos = require("./verificar_documentos.js");
exports.verificarDocumentos = verificarDocumentos.verificarDocumentos;
const classificarDocBahamas = require("./classificar_doc_bahamas.js");
exports.classificarDocBahamas = classificarDocBahamas.classificarDocBahamas;
