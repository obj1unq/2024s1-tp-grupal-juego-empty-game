import wollok.game.*
import balas.*
import nave.*
import posiciones.*
import juego.*
import barrera.*
import ComportamientoMovimientos.*
import mock.*
import score.*

object flota {

	var property estadoMovimiento = estadoADerecha
	const property aliens = []

	method agregarAlien(alien) {
		aliens.add(alien)
	}

	method eliminarAlien(alien) {
		aliens.remove(alien)
	}

	method spawn() {
		game.onTick(juego.dificultad(), "moverAlien", { self.moverAliens()})
	}

	method moverAliens() {
		estadoMovimiento.actualizar(self)
		self.moverA(estadoMovimiento.direccion())
	}

	method moverA(direccion) {
		aliens.forEach({ alien => alien.mover(direccion)})
	}

	method xs() {
		return aliens.map({ alien => alien.position().x() })
	}

	method maxX() {
		return self.xs().max()
	}

	method minX() {
		return self.xs().min()
	}

	method vaciarFlota() {
		aliens.clear()
	}

	method congelarFlota() {
		game.removeTickEvent("moverAlien")
	}

}

class Alien {

	var property position
	const equipo = flota
	const arma = balasManagerAlien
	const property sonidoMuerteAlien = "muerte_alien.mp3"
	var property estadoMovimiento = s

	method image()

	method puntos()

	method nacer() {
		game.addVisual(self)
		game.onTick(juego.dificultad(), "AlienDisparo", { arma.generar()})
		game.onCollideDo(self, { algo => self.reaccionColision(algo)})
		equipo.agregarAlien(self)
	}

	method reaccionColision(algo) {
		if (not algo.puedoMatarlo(self)) {
		} else {
			muerte.generarExplosion(position)
			self.morirPor(algo)
		}
	}

	method mover(direccion) {
		const proxima = direccion.siguiente(self.position())
		self.position(proxima)
		estadoMovimiento = estadoMovimiento.siguiente()
	}

	method puedoMatarlo(algo) {
		return true
	}

	method morirPor(algo) {
		const sonido = soundProducer.sound(sonidoMuerteAlien)
		sonido.volume(0.2)
		algo.collide(self)
		game.removeVisual(self)
		equipo.eliminarAlien(self)
		sonido.play()
		juego.ganarSiPuedo()
	}

	method collide(algo) {
	}

}

class AlienRojo inherits Alien {

	var vidas = 1

	override method image() {
		return "alien_rojo_" + estadoMovimiento + ".png"
	}

	override method puntos() {
		if (vidas > 0) {
			return 0
		} else {
			return 40
		}
	}

	override method reaccionColision(algo) {
		const sonido = soundProducer.sound(sonidoMuerteAlien)
		sonido.volume(0.2)
		if (not algo.puedoMatarlo(self)) {
		} else if (vidas > 0) {
			sonido.play()
			algo.collide(self)
			vidas -= 1
		} else {
			muerte.generarExplosion(position)
			self.morirPor(algo)
		}
	}

}

class AlienVerde inherits Alien {

	override method image() {
		return "alien_verde_" + estadoMovimiento + ".png"
	}

	override method puntos() {
		return 20
	}

	override method reaccionColision(algo) {
		super(algo)
		arma.generar()
	}

}

class AlienAmarillo inherits Alien {

	override method image() {
		return "alien_amarillo_" + estadoMovimiento + ".png"
	}

	override method puntos() {
		return 10
	}

}

object p {

	method siguiente() {
		return s
	}

}

object s {

	method siguiente() {
		return p
	}

}

class Explosion {

	var property image = "explosion.png"

	method explotar(position) {
		game.addVisualIn(self, position)
		game.schedule(100, { game.removeVisual(self)})
	}

	method puedoMatarlo(algo) {
		return false
	}

}

object muerte {

	method puedoMatarlo(algo) {
	}

	method generarExplosion(position) {
		const muerte = new Explosion()
		muerte.explotar(position)
	}

}

