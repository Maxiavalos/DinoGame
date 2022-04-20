import wollok.game.*

const velocidad = 250

object juego{

	method configurar(){
		game.boardGround("paisaje.jpg")
		game.width(12)
		game.title("Dino Game")
		game.addVisual(suelo)
		game.addVisual(cactus)
		game.addVisual(cactus2)
		game.addVisual(cactus3)
		game.addVisual(dino)
		game.addVisual(reloj)
		keyboard.space().onPressDo{ self.jugar()}
		
		game.onCollideDo(dino,{ obstaculo => self.terminar()})
		
	}
	
	method iniciar(){
		dino.iniciar()
		reloj.iniciar()
		cactus.iniciar()
		cactus2.iniciar()
		cactus3.iniciar()
	}
	
	method jugar(){
		if (dino.activo())
			dino.saltar()
		else {
			game.removeVisual(gameOver)
			self.iniciar()
		}
	}
	
	method terminar(){
		game.removeTickEvent("moverCactus")
		////
		game.removeTickEvent("moverCactus2")
		game.removeTickEvent("moverCactus3")
		game.removeTickEvent("tiempo")
		game.addVisual(gameOver)
		dino.detener()
	}
	
}

object gameOver {
	method position() = game.center()
	method text() = "GAME OVER"
	

}

object reloj {
	
	var tiempo = 0
	
	method text() = tiempo.toString()
	method position() = game.at(1, game.height()-1)
	
	method pasarTiempo() {
		tiempo = tiempo +1
	}
	method iniciar(){
		tiempo = 0
		game.onTick(100,"tiempo",{self.pasarTiempo()})
	}
}

object cactus {
	 
	const posicionInicial = game.at(game.width()-1,1)
	var position = posicionInicial

	method image() = "cactus.png"
	method position() = position
	
	method iniciar(){
		position = posicionInicial
		game.onTick(velocidad,"moverCactus",{self.mover()})
		
			
	}
	
	method mover(){
		position = position.left(1)
		if (position.x() == -1)
			position = posicionInicial
	}
		

}


object cactus2 {
	 
	const posicionInicial2 = game.at(game.width()-1,2)
	var position = posicionInicial2

	method image() = "cactus.png"
	method position() = position
	
	method iniciar(){
		position = posicionInicial2
		game.onTick(velocidad * 2,"moverCactus2",{self.mover()})
		game.schedule(300, { game.say(self, "¡Voy a matarte, bastardo!") })
		
			
	}
	
	method mover(){
		position = position.left(1)
		if (position.x() == -1)
			position = posicionInicial2
	}
		

}

object cactus3 {
	 
	const posicionInicial3 = game.at(game.width()-1,2)
	var position = posicionInicial3

	method image() = "cactus.png"
	method position() = position
	
	method iniciar(){
		position = posicionInicial3
		game.onTick(velocidad * 6,"moverCactus3",{self.mover()})
		
			
	}
	
	method mover(){
		position = position.left(1)
		if (position.x() == -1)
			position = posicionInicial3
	}
		

}


object suelo{
	
	method position() = game.origin().up(1)
	method image() = "suelo.png"
}


object dino {
	var activo = true
	var position = game.at(1,1)
	
	method image() = "dino.png"
	method position() = position
	
	method position(nueva){
		position = nueva
	}
	
	method iniciar(){
		activo = true
	}
	method saltar(){
		if(position.y() == 1) {
			self.subir()
			game.schedule(velocidad*3,{self.bajar()})
		}
		
	}
	
	method subir(){
		position = position.up(1)
	}
	method bajar(){
		position = position.down(1)
	}
	method detener(){
		activo = false
	}
	method activo() = activo
}