import wollok.game.*
import proyectiles.*
import randomizer.*
import direcciones.*

/*comentarios : se supone que donde este el jefe no sea una zona que pueda atravezar el heroe, pues como ataca
 * hacia abajo solo, que no se pueda que el jugador se ponga al lado y ataque sin peligro
 * por eso no tiene colision, tampoco puse metodos de recibir daño pues no se como se diseñaran
 * los ataques del heroe, las partes deberian ser inmunes al daño pues es para aumentar dificultad
 al pasar a "la otra fase"*/
object jefe {

	var property cantidadEscudos = 3
	var property position = game.at(7, 9)
	var aguanteEscudo = 90
	var aguante = 40
	var property moviendoA = derecha
	const partes = []

	method aguante() {
		return aguante
	}

	method iniciar() {
		self.activarMovimiento()
		self.activarAtaques()
	}

	method activarAtaques() {
		game.onTick(4000, "Ataques Boss", { self.atacar()})
	}

	method activarMovimiento() {
		game.onTick(500, "Movimiento de boss", {=> self.mover()})
	}

	method mover() {
		// este metodo supone toda la ventana como posible movimiento
		if (direcciones.esUnBorde(moviendoA.siguiente(position) )) {
			self.moviendoA((self.moviendoA().opuesto()))
			self.position(self.moviendoA().siguiente(self.position()))
		} else {
			self.position(self.moviendoA().siguiente(self.position()))
		}
	}

	method separarParte() {
		// este si se agregan mas bordes que sean con objetos asi no aparece encima una parte
		const parte = new ParteBoss(position = randomizer.emptyPosition())
		parte.iniciar()
		partes.add(parte)
	}

	method escudos() {
		return if (self.cantidadEscudos() > 0) self.cantidadEscudos().toString() else "Vulnerable"
	}

	method image() {
		return "boss_" + self.escudos() + ".png"
	}

	method removerEscudo() {
		if (cantidadEscudos > 0) cantidadEscudos -= 1
	}

	method aguanteEscudo() {
		return aguanteEscudo
	}

	method recibirDanio(cantidad) {
		if (self.aguanteEscudo() > 0) {
			aguanteEscudo = (aguanteEscudo - cantidad).max(0)
			self.comprobarCantidadEscudos()
		} else {
			aguante = (aguante - cantidad).max(0)
			self.comprobarAguante()
		}
	}

	method comprobarCantidadEscudos() {
		if (self.aguanteEscudo() <= (self.cantidadEscudos() - 1) * 30) {
			cantidadEscudos -= 1
			self.separarParte()
		}
	}

	method comprobarAguante() {
		if (aguante == 0) self.serDerrotado()
	}

	method atacar() {
		new Proyectil(direccion = abajo , position = self.position(), tipoProyectil = "Jefe", danio = 10).disparar()
	}

	method serDerrotado() {
		game.removeTickEvent("Ataques Boss")
		game.removeVisual(self)
		partes.forEach({ parte => parte.eliminarse()})
	}
	
	method esAtravesable() {
		return false
	}

}

class ParteBoss {

	var property direccionMirada = direcciones.mirandoAlHeroe(self.position())
	var property position

	method iniciar() {
		game.addVisual(self)
		game.onTick(4000, "DispararParte" + self.identity().toString(), { self.disparar()})
	}

	method esAtravesable() {
		return false
	}

	method image() {
		return "Boss_Parte.png"
	}

	method disparar() {
		direccionMirada = direcciones.mirandoAlHeroe(self.position())
		new Proyectil(direccion = direccionMirada , position = self.position(), tipoProyectil = "ParteBoss", danio = 10).disparar()
	}

	method eliminarse() {
		game.removeVisual(self)
	}

}

