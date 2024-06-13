import wollok.game.*

//DIRECCIONES
object arriba {
	method siguiente(position) {
		return position.up(1)
	}
	method opuesto() {
		return abajo
	}
	method siguiente() {
		return derecha
	}
}

object abajo {
	method siguiente(position) {
		return position.down(1)
	}	
	method opuesto() {
		return arriba
	}
	method siguiente() {
		return izquierda
	}
}

object izquierda {
	method siguiente(position) {
		return position.left(1)
	}
	method opuesto() {
		return derecha
	}
	method siguiente() {
		return arriba
	}
}
object derecha {
	method siguiente(position) {
		return position.right(1)
	}
	method opuesto() {
		return izquierda
	}
	method siguiente() {
		return abajo
	}
}