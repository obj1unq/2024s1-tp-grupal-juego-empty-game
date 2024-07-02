import wollok.game.*
import nave.*
import aliens.*
import juego.*
import mock.*

object pantallaInicio {

	var property position = game.at(3, 5)
	var property image = "pantallaInicio.png"
	const property sonidoMenu = "menu.mp3"

	method cargar() {
		const sonido = soundProducer.sound(sonidoMenu)
		sonido.volume(0.2)
		game.addVisual(self)
		sonido.shouldLoop(true)
		game.schedule(500, { sonido.play()})
		game.onTick(800, "start", { pressStart.titilar()})
		keyboard.enter().onPressDo{ game.clear()
			game.addVisual(presentacion)
			sonido.stop()
			sonidoFondo.reproducirSonidoMenu()
			game.schedule(1000, { juego.empezar()})
		}
	}

}

object presentacion {

	const property position = game.at(0, 0)
	const property image = "presentacion.png"

}

object pressStart {

	var property image = "pressStart.png"

	method titilar() {
		game.addVisualIn(self, game.at(6, 1))
		game.schedule(300, { game.removeVisual(self)})
	}

}

object sonidoFondo {

	const property sonidoFondo = soundProducer.sound("sonido_fondo.mp3")

	method reproducirSonidoMenu() {
		sonidoFondo.shouldLoop(true)
		sonidoFondo.volume(0.2)
		sonidoFondo.play()
	}

	method pausar() {
		sonidoFondo.pause()
	}

}


