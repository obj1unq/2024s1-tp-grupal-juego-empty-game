import wollok.game.*
import aliens.*

object flotaDeBarreras {

	const property barreras = []

	method spawn() {
		barreras.forEach({ barrera => barrera.nacer()})
	}

	method agregarBarrera(barrera) {
		barreras.add(barrera)
	}

	method eliminarBarrera(barrera) {
		barreras.remove(barrera)
	}

}

class Barrera {

	var property position = null
	var property salud = 3
	const muro = flotaDeBarreras

	method image()

	method nacer() {
		game.addVisual(self)
		game.onCollideDo(self, { algo => self.reaccionColision(algo)})
		muro.agregarBarrera(self)
	}

	method reaccionColision(algo) {
		if (salud == 1) {
			algo.collide(self)
			muro.eliminarBarrera(self)
			game.removeVisual(self)
		} else {
			algo.collide(self)
			salud -= 1
		}
	}

	method puedoMatarlo(algo) {
		return flota.aliens().contains(algo)
	}

	method collide(algo) {
	}
	method puntos() {
		return 0
	}

}

class BarreraGris inherits Barrera {

	override method image() {
		return "barrera_gris" + salud + ".png"
	}

}

class BarreraMarron inherits Barrera {

	override method image() {
		return "barrera_marron" + salud + ".png"
	}

}

