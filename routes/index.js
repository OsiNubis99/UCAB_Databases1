const { Router } = require("express");
const router = Router();
const {
	createSubasta,
	getColeccionistas,
	getTiendas,
	getSubasta,
	putSubasta,
	getPais,
	createCostoEnvio,
	getSubastasTiendas,
	getCatalogosPintura,
	getCatalogosMoneda,
} = require("../controller/index");

router.get("/Tiendas", getTiendas);
router.post("/crearSubasta", createSubasta);
router.get("/coleccionistas", getColeccionistas);
router.get("/Pais", getPais);
router.post("/crearCostoEnvio", createCostoEnvio);
router.get("/subastas", getSubastasTiendas);
router.get("/catalogoPintura", getCatalogosPintura);
router.get("/catalogoMoneda", getCatalogosMoneda);
router.post("/subasta/:subastaId/put", putSubasta);
router.post("/subasta/:subastaId/get", getSubasta);
module.exports = router;
