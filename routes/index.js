const { Router } = require("express");
const router = Router();
const {
  getUsuario,
  getPersona,
  getEmpleado,
  getAgente,
  getCliente,
  getPoliza,
  getVehiculo,
  getVida,
  getCategoria,
  getTipo,
  getSucursal,
  getContVida,
  getContVehiculo,
  getContInmueble,
  getInmueble,
  createUsuario,
  createPersona,
  createEmpleado,
  createAgente,
  createCliente,
  createPoliza,
  createInmueble,
  createVehiculo,
  createVida,
  createCategoria,
  createTipo,
  createSucursal,
  createContVida,
  createContInmueble,
  createContVehiculo
} = require("../controller/index");

router.get("/usuarios", getUsuario);
router.get("/personas", getPersona);
router.get("/empleados", getEmpleado);
router.get("/agentes", getAgente);
router.get("/clientes", getCliente);
router.get("/polizas", getPoliza);
router.get("/inmuebles", getInmueble);
router.get("/sucursales", getSucursal);
router.get("/vehiculos", getVehiculo);
router.get("/vidas", getVida);
router.get("/categorias", getCategoria);
router.get("/tipo_cobertura", getTipo);
router.get("/sucursales", getSucursal);
router.get("/contratos_Vehiculo", getContVehiculo);
router.get("/contratos_Vida", getContVida);
router.get("/contratos_Inmueble", getContInmueble);

router.post("/usuario", createUsuario);
router.post("/persona", createPersona);
router.post("/empleado", createEmpleado);
router.post("/agente", createAgente);
router.post("/cliente", createCliente);
router.post("/poliza", createPoliza);
router.post("/inmueble", createInmueble);
router.post("/vehiculo", createVehiculo);
router.post("/vida", createVida);
// router.post("/categoria", createCategoria);
// router.post("/tipo_cobertura", createTipo);
// router.post("/sucursal", createSucursal);
router.post("/contrata_Vehiculo", createContVehiculo);
router.post("/contrata_Vida", createContVida);
router.post("/contrata_Inmueble", createContInmueble);
module.exports = router;
