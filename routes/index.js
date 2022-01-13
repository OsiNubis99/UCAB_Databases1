const { Router } = require("express");
const router = Router();
const {
  getAgente,
  getCliente,
  getSucursal,
  getContVehiculo,
  getVehiculo,
  getCategoria,
  getTipo,
  getContVida,
  getVida,
  getPersona,
  getContInmueble,
  getInmueble,
  createAgente,
  createCliente,
  createContVehiculo,
  createVehiculo,
  createCategoria,
  createTipo,
  createContVida,
  createVida,
  createPersona,
  createContInmueble,
  createInmueble
} = require("../controller/index");

router.get("/agentes", getAgente);
router.get("/clientes", getCliente);
router.get("/sucursales", getSucursal);
router.get("/contratos_Vehiculo", getContVehiculo);
router.get("/vehiculos", getVehiculo);
// router.get("/categorias", getCategoria);
// router.get("/tipo_cobertura", getTipo);
router.get("/contratos_Vida", getContVida);
router.get("/vidas", getVida);
router.get("/personas", getPersona);
router.get("/contratos_Inmueble", getContInmueble);
router.get("/inmuebles", getInmueble);
router.post("/agente", createAgente);
// router.post("/cliente", createCliente);
router.post("/contrata_Vehiculo", createContVehiculo);
// router.post("/vehiculo", createVehiculo);
// router.post("/categoria", createCategoria);
// router.post("/tipo_cobertura", createTipo);
router.post("/contrata_Vida", createContVida);
// router.post("/vida", createVida);
router.post("/persona", createPersona);
router.post("/contrata_Inmueble", createContInmueble);
router.post("/inmueble", createInmueble);
module.exports = router;
