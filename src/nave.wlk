import wollok.game.*
import posiciones.*
import aliens.*
import balas.*
import gameOver.*
import mock.*

object nave {

	var property position = null
	const property arma = balasManagerNave
	var property salud
	const vida = []
	var property image = "nave.png"
	const property impacto = "golpeNave.mp3"

	method disparar() {
		if (game.hasVisual(self)) {
			arma.generar()
		}
	}

	method bloquear() {
		position = game.at(self.position().x(), 0)
	}

	method reaccionColision(algo) {
		if (not algo.puedoMatarlo(self) or flota.aliens().isEmpty()) {
		} else if (salud == 1) {
			self.danio()
			gameOver.perder()
		} else {
			self.danio()
			salud -= 1
		}
	}

	method danio() {
		const sonido = soundProducer.sound(impacto)
		sonido.volume(0.2)
		image = "naveDanio.png"
		game.schedule(300, { image = "nave.png"})
		sonido.play()
		vida.last().morir()
	}

	method addCorazon(corazon) {
		vida.add(corazon)
	}

	method quitarCorazon(corazon) {
		vida.remove(corazon)
	}

	method puedoMatarlo(algo) {
		return false
	}

}

class Corazon {

	var property position = null
	var estado = 1

	method nacer() {
		game.addVisual(self)
		nave.addCorazon(self)
	}

	method image() {
		return "corazon" + estado + ".png"
	}

	method morir() {
		nave.quitarCorazon(self)
		estado = 2
	}

}


