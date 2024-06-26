import wollok.game.*
import froggi.*

class Obstaculo {

	var property position
	var property velocidad

	method colision(personaje) {
		personaje.quitarVida(self.damage()) // Polimorfismo con froggi, es necesario crearlo en froggi
	}

	method image()

	method actualizarMoviento() {
		if (self.estoyEnElBordeDelTablero()) { // El parametro signfica borde izquierdo
			self.detenerMovimiento()
		} else {
			position = self.siguientePosicion()
		}
	}

	method siguientePosicion() {
		return position.right(1)
	}

	method detenerMovimiento() {
		game.removeTickEvent(self.nombreOnTick())
		game.removeVisual(self)
		spawnerDeObstaculo.quitarVehiculo(self)
		console.println("Se elimino Vehiculo")
	}

	method nombreOnTick() {
		return "MOVER VEHICULO" + self.identity()
	}

	method iniciarMovimiento() {
		game.onTick(velocidad, self.nombreOnTick(), { self.actualizarMoviento()})
	}

	method cambiarTipo(stringObstaculo) {
		return stringObstaculo + 1.randomUpTo(3).roundUp().toString() + ".png"
	}

	method estoyEnElBordeDelTablero() {
		return self.position().x() == game.width() - 1
	}

	method damage()

}

class Tronco inherits Obstaculo {

	override method image() {
		return "tronco2.png"
	}

	override method colision(personaje) {
		personaje.movimiento(new SobreTronco(transporte = self , personaje = personaje))
	}

	override method damage() {
		return 0
	}

}

class TroncoInvertido inherits Tronco {

	override method image() {
		return "tronco2.png"
	}


	override method damage() {
		return 0
	}

	override method siguientePosicion() {
		return position.left(1)
	}

	override method estoyEnElBordeDelTablero() {
		return self.position().x() == 0
	}

}

class Camion inherits Obstaculo {

	const camiones
	const property damage = 3

	override method image() {
		return camiones
	}

	override method colision(personaje) {
		personaje.position(game.at(personaje.position().x(), personaje.position().y() - 1))
		super(personaje)
	}

}

class CamionInvertido inherits Camion {

	override method siguientePosicion() {
		return position.left(1)
	}

	override method estoyEnElBordeDelTablero() {
		return self.position().x() == 0
	}

}

class Moto inherits Obstaculo {

	const property damage = 1

	override method image() {
		return "motoPrueba2.png"
	}

	override method siguientePosicion() {
		return position.left(1)
	}

	override method estoyEnElBordeDelTablero() {
		return self.position().x() == 0
	}

}

class Auto inherits Obstaculo {

	const property damage = 2
	const property autos

	override method image() {
		return autos
	}

}

object spawnerDeObstaculo {
	
	const cordDelAgua = 6
	
	var property personaje = null 

	const property vehiculos = []

	method troncoFactory(pos_y) {
		var tronco
		if (pos_y.even()) {
			tronco = new Tronco(velocidad = 800, position = game.at(0, pos_y + cordDelAgua))
		} else {
			tronco = new TroncoInvertido(velocidad = 800, position = game.at(game.width() - 1, pos_y + cordDelAgua))
		}
		self.inicializarVehiculo(tronco)
	}

method autoFactory(){
		const auto = new Auto( velocidad = 600 ,position= game.at(0, 3)  , autos = ["auto1.png" , "auto3.png"].anyOne())
		self.inicializarVehiculo(auto)
//		return auto
	}
	
	method motoFactory(){
		const moto = new Moto (velocidad = 300,  position= game.at(game.width() - 1, 2))
		self.inicializarVehiculo(moto)
//		return moto
	}
	
	method camionFactory(){
		const camion = new Camion (velocidad = 900,  position= game.at(0, 1) , camiones = ["camion-verde.png" , "camion-rojo.png"].anyOne())
		self.inicializarVehiculo(camion)
//		return camion
	}
	
	method camionRapidoFactory(){
		const camion = new CamionInvertido (velocidad = 500,  position= game.at(game.width() - 1, 4) , camiones = ["camion-verde-invertido.png" , "camion-rojo-invertido.png"].anyOne())
		self.inicializarVehiculo(camion)
//		return camion
	}
	
	method inicializarVehiculo(vehiculo) {
		game.addVisual(vehiculo)
		vehiculo.iniciarMovimiento()
		vehiculos.add(vehiculo)
		game.removeVisual(personaje)
		game.addVisual(personaje) // Se utiliza este method para que el personaje siempre este por encima
		
	}
	
	method init() {
		game.onTick(3000, "SPAWNER DE AUTO", { self.autoFactory()})
		game.onTick(2500, "SPAWNER DE MOTO", { self.motoFactory()})
		game.onTick(7000, "SPAWNER DE CAMION", { self.camionFactory()})
		game.onTick(5000, "SPAWNER DE CAMION RAPIDO", { self.camionRapidoFactory()})
		(1..5).forEach({index => game.onTick(3500 + index * 500, "SPAWNER DE TRONCO" + index, { self.troncoFactory(index)})})
		
//		game.onTick(3500, "SPAWNER DE TRONCO1", { self.troncoFactory(1)})
//		game.onTick(4000, "SPAWNER DE TRONCO2", { self.troncoFactory(2)})
//		game.onTick(6000, "SPAWNER DE TRONCO3", { self.troncoFactory(3)})
//		game.onTick(4500, "SPAWNER DE TRONCO4", { self.troncoFactory(4)})
//		game.onTick(5500, "SPAWNER DE TRONCO5", { self.troncoFactory(5)})
}
//
	method quitarAutos() {
		// Quita todos los autos que este en pantalla y para los onTick
		game.removeTickEvent("SPAWNER DE AUTO")
		game.removeTickEvent("SPAWNER DE MOTO")
		game.removeTickEvent("SPAWNER DE CAMION")
		game.removeTickEvent("SPAWNER DE CAMION RAPIDO")
		(1..5).forEach({index => game.removeTickEvent("SPAWNER DE TRONCO" + index)})
//		game.removeTickEvent("SPAWNER DE TRONCO1")
//		game.removeTickEvent("SPAWNER DE TRONCO2")
//		game.removeTickEvent("SPAWNER DE TRONCO3")
//		game.removeTickEvent("SPAWNER DE TRONCO4")
//		game.removeTickEvent("SPAWNER DE TRONCO5")
		vehiculos.forEach{ auto => auto.detenerMovimiento()}
	}
	
	method quitarVehiculo(vehiculo){
		vehiculos.remove(vehiculo)
	}
	
}

