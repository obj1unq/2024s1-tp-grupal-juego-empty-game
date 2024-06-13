import wollok.game.*
import nave.*
import aliens.*
import posiciones.*
import nivel.*
import inicio.*
import balas.*
import mapa.*

object juego {

	method empezar() {
		game.clear()
		
		// comportamieno de Nave
		mapa.generar()
		keyboard.up().onPressDo({nave.bloquear()})
		keyboard.space().onPressDo({nave.disparar()})
	}
}
