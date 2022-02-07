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
  getSiniestro,
  getAccidente,
  getCategoria_acc,
  getMulta,
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
  createSiniestro,
  createMulta,
  createAccidente,
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
router.get("/siniestros", getSiniestro);
router.get("/accidentes", getAccidente);
router.get("/categoria_accs", getCategoria_acc);
router.get("/multas", getMulta);
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
router.post("/siniestro", createSiniestro);
router.post("/accidente", createAccidente);
router.post("/multa", createMulta);
router.post("/contrata_Vehiculo", createContVehiculo);
router.post("/contrata_Vida", createContVida);
router.post("/contrata_Inmueble", createContInmueble);
module.exports = router;
