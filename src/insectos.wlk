import wollok.game.*
import froggi.*
import randomizer.*

class Mosquito {

	var property position = randomizer.emptyPosition()

	method image() {
		return "mosquito.png"
	}

	method colision(objeto) {
			
		objeto.validarCrecimiento()
		objeto.actualizarEstado()
		objeto.agregarVida(1)
		game.removeVisual(self)
		insectoManager.insectos().remove(self)
	}
}

class Mosca {

	var property position = randomizer.emptyPosition()

	method image() {
		return "mosca.png"
	}

	method colision(objeto) {
		objeto.agregarVida(1)
		game.removeVisual(self)
		insectoManager.insectos().remove(self)
	}
	
}

object insectoManager {
	
	const property insectos = []

	method crearInsecto() {
		if (insectos.size() < 5) {
			insectos.add([ mosquitoFactory, moscaFactory ].anyOne().crearInsecto())
		}
	}
}

object mosquitoFactory {

	method crearInsecto() {
		const mosquito = new Mosquito()
		game.addVisual(mosquito)
		return mosquito
	}	
}

object moscaFactory {

	method crearInsecto() {
		const mosca = new Mosca()
		game.addVisual(mosca)	
		return mosca
	}
}
