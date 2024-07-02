import posiciones.*

import wollok.game.*

object bajarHilera {

	var yaBajo = false 
	var cantBajadas = 0
	var estadoSiguiente = estadoAIzquierda
	
	method actualizar(flota) {
		if (yaBajo) {
			if(cantBajadas.even()) {
			estadoSiguiente = estadoADerecha	
			flota.estadoMovimiento(estadoSiguiente)
			yaBajo = false
			}
			else {
				estadoSiguiente = estadoAIzquierda
				flota.estadoMovimiento(estadoSiguiente)
			}	
		}
	}

	method direccion() {
		yaBajo = true
		cantBajadas = cantBajadas + 1 
		return abajo
	}

}

object estadoADerecha {

	const estadoSiguiente = bajarHilera

	method actualizar(flota) {
		if (flota.maxX() == game.width() - 1) {
			flota.estadoMovimiento(estadoSiguiente)
		}
	}

	method direccion() {
		return derecha
	}

}

object estadoAIzquierda {

	const estadoSiguiente = bajarHilera

	method actualizar(flota) {
		if (flota.minX() == 0) {
			flota.estadoMovimiento(estadoSiguiente)
		}
	}

	method direccion() {
		return izquierda
	}
}	
	