import wollok.game.*
import nave.*
import aliens.*
import posiciones.*
import inicio.*
import balas.*
import mapa.*
import barrera.*
import gameOver.*
import mock.*

object juego {

	var property dificultad = 1000

	method empezar() {
		game.clear()
		self.restart()
		mapa.generar()
			// comportamieno de Nave
		nave.salud(3)
		keyboard.up().onPressDo({ nave.bloquear()})
		keyboard.space().onPressDo({ nave.disparar()})
		game.onCollideDo(nave, { bala => nave.reaccionColision(bala)})
	}

	method restart() {
		balasManagerAlien.recargar()
		balasManagerNave.recargar()
		flota.vaciarFlota()
	}

	method aumentarDificultad() {
		dificultad -= 100
	}

	method ganarSiPuedo() {
		if (flota.aliens().isEmpty()) {
			const sonido = soundProducer.sound("win.mp3")
			sonido.play()
			flota.congelarFlota()
			game.schedule(700, { self.empezar()})
			self.aumentarDificultad()
		}
	}

}


