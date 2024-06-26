import wollok.game.*
import froggi.*
import randomizer.*
import obstaculos.*

class Consumible {

	var property position = randomizer.emptyPosition()

	method colision(objeto) {
		objeto.agregarPuntos(self.puntosQueAporta())
		game.removeVisual(self)
		self.aplicarComportamiento(objeto)
	}

	method puntosQueAporta() {
		return 0
	}

	method aplicarComportamiento(personaje) {
	}

}

class Fruta inherits Consumible {

	override method colision(objeto) {
		super(objeto)
		consumiblesManager.frutas().remove(self)
	}

}

class Banana inherits Fruta {

	method image() {
		return "banana.png"
	}

	override method puntosQueAporta() {
		return 300
	}

}

class Uva inherits Fruta {

	method image() {
		return "uva.png"
	}

	override method puntosQueAporta() {
		return 200
	}

}

class Manzana inherits Fruta {

	method image() {
		return "manzana-roja.png"
	}

	override method puntosQueAporta() {
		return 100
	}

}

class Insecto inherits Consumible {

	override method colision(objeto) {
		objeto.agregarVida(1)
		super(objeto)
		consumiblesManager.insectos().remove(self)
	}

}

class Mosquito inherits Insecto {		//Solo se crea 1 en la escena actual

	method image() {
		return "mosquito.png"
	}

	override method aplicarComportamiento(personaje) {
		//Te teletransporta a la próxima safe zone
		personaje.position(game.at(9 , 5))
	}

}

class Mosca inherits Insecto {

	method image() {
		return "mosca.png"
	}

	override method aplicarComportamiento(personaje) {
		spawnerDeObstaculo.quitarAutos()
		spawnerDeObstaculo.init()
	}

}

object consumiblesManager {

	const property insectos = []
	const property frutas = []

	method crearInsecto() {
		if (insectos.size() < 3) {
			const insecto = [ {new Mosquito()}, {new Mosca()} ].anyOne().apply()
			self.agregarConsumible(insecto, insectos)
		// console.println(insectos)
		}
	}

	method crearFruta() {
		if (frutas.size() < 6) {
			const fruta = [ {(new Manzana())}, {(new Uva())}, {(new Banana())} ].anyOne().apply()
			self.agregarConsumible(fruta, frutas)
			//console.println(frutas)
		// frutas.add([self.creador((new Manzana())), self.creador((new Uva())) , (new Banana())].anyOne())
		}
	}

	method agregarConsumible(consumible, listaConsumible) {
		listaConsumible.add(consumible)
		game.addVisual(consumible)
	}

}
