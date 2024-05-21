import wollok.game.*
import nave.*
import extras.*
import posiciones.*
import nivel.*
import inicio.*
import balas.*

object juego {

	method empezar() {
		game.clear()
		game.addVisualCharacter(nave)
		flota.spawn()
		
		// comportamieno de Nave
		keyboard.up().onPressDo({nave.bloquear()})
		keyboard.space().onPressDo({nave.disparar()})
	}
}
