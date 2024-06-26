import wollok.game.*
import config.*

class Nenufar {

	var property position

	method image() {
		return "Nenufar32x32.png"
	}

	method colision(objeto) {
		self.actualizarVictoria(objeto)
	}

	method actualizarVictoria(jugador) {
		if (jugador.cantidadDeVecesGanadas() < 2) {		//Al tercero debo indicar que el jugador gano
			jugador.position(game.origin())
			jugador.aumentarVecesGanadas()
			game.addVisualIn(new RanaGanadora(), self.position())
			game.removeVisual(self)
		}else{
			configuracionJuego.terminarJuego(pantallaVictoria)
		}
	}

}

class RanaGanadora{
	method image() {
		return "RanitaGanadora32x32.png"
	}
	
	method colision(objeto) {
		objeto.quitarVida(1)
		objeto.position(game.origin())
	}
}