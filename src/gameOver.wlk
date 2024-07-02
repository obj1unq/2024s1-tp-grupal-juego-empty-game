import wollok.game.*
import juego.*
import nave.*
import aliens.*
import inicio.*
import mock.*
import score.*

object gameOver {

	var property position = game.at(0, 0)
	var property image = "game_Over.png"
	const property sonidoMenu = "menu.mp3"
	const property sonidoMuerte = "gameOver.mp3"
	var puntosFinales = 0
	const primerD = new PrimerD(position = game.at(15, 7) )
	const segundD = new SegundoD(position = game.at(14, 7) )
	const tercerD = new TercerD(position = game.at(13, 7) )
	const cuartoD = new CuartoD(position = game.at(12, 7) )

	method perder() {
		const sonido = soundProducer.sound(sonidoMuerte)
		sonidoFondo.pausar()
		sonido.volume(0.2)
		sonido.play()
		flota.congelarFlota()
		game.removeVisual(nave)
		game.schedule(4000, { self.pantallaFinal()})
	}

	method pantallaFinal() {
		const sonido = soundProducer.sound(sonidoMenu)
		sonido.volume(0.2)
		puntosFinales = score.valor()
		game.clear()
		game.addVisual(self)
		sonido.shouldLoop(true)
		sonido.play()
		score.valor(puntosFinales)
		game.addVisualIn(score,game.at(7, 7) )
		game.addVisual(primerD)
		game.addVisual(segundD)
		game.addVisual(tercerD)
		game.addVisual(cuartoD)
		keyboard.r().onPressDo{ game.clear()
			sonido.stop()
			game.addVisual(presentacion)
			juego.dificultad(1000)
			sonidoFondo.sonidoFondo().resume()
			game.schedule(600, { juego.empezar()})
		}
		keyboard.x().onPressDo{ game.stop()}
	}

}


