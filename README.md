ooooooooo.             oooo                     
`888'   `Y8b            `888                     
 888      888  .ooooo.   888   .oooo.o  .oooo.   
 888      888 d88' `88b  888  d88(  "8 `P  )88b  
 888      888 888ooo888  888  `"Y88b.   .oP"888  
 888     d88' 888    .o  888  o.  )88b d8(  888  
o888bood8P'   `Y8bod8P' o888o 8""888P' `Y888""8o 

## Robo de señales de tráfico

Robo, desguace, eviso a la policía y emote

### Dependencias:
* [qb-target](https://github.com/BerkieBb/qb-target)
* [ps-ui](https://github.com/Project-Sloth/ps-ui)
* [dpemotes](https://github.com/andristum/dpemotes)

### Items a añadir al core:
```lua
	["giroizquierda"] 			= {["name"] = "giroizquierda", 		["label"] = "Señal de giro a la izquierda", ["weight"] = 1, 	["type"] = "item", 		["image"] = "giroizquierda.png", 			["unique"] = false, 	["useable"] = true, 		["shouldClose"] = true, 	["combinable"] = nil, ["ilegal"] = true, ["description"] = "Señal de tráfico."},
	["giroderecha"] 			= {["name"] = "giroderecha", 		["label"] = "Señal de  giro a la derecha", ["weight"] = 1, 		["type"] = "item", 		["image"] = "giroderecha.png", 			["unique"] = false, 	["useable"] = true, 		["shouldClose"] = true, 	["combinable"] = nil, ["ilegal"] = true, ["description"] = "Señal de tráfico."},
	["nopasar"] 		= {["name"] = "nopasar", 	["label"] = "Señal de No pasar", 		["weight"] = 1, 		["type"] = "item", 		["image"] = "nopasar.png", 		["unique"] = false, 	["useable"] = true, 		["shouldClose"] = true, 	["combinable"] = nil, ["ilegal"] = true, ["description"] = "Señal de tráfico."},
	["ceda"] 				= {["name"] = "ceda", 			["label"] = "Ceda el paso", 			["weight"] = 1, 		["type"] = "item", 		["image"] = "ceda.png", 				["unique"] = false, 	["useable"] = true, 		["shouldClose"] = true, 	["combinable"] = nil, ["ilegal"] = true, ["description"] = "Señal de tráfico."}, 
  ["stop"] 				= {["name"] = "stop", 			["label"] = "Señal de Stop", 			["weight"] = 1, 		["type"] = "item", 		["image"] = "stop.png", 				["unique"] = false, 	["useable"] = true, 		["shouldClose"] = true, 	["combinable"] = nil, ["ilegal"] = true, ["description"] = "Señal de tráfico."},
	["peatones"] 			= {["name"] = "peatones", 	["label"] = "Señal de paso de peatones", ["weight"] = 1, 		["type"] = "item", 		["image"] = "peatones.png", 			["unique"] = false, 	["useable"] = true, 		["shouldClose"] = true, 	["combinable"] = nil, ["ilegal"] = true, ["description"] = "Señal de tráfico."},
	["interseccion"] = {["name"] = "interseccion", ["label"] = "Señal de no bloquear intersección", 		["weight"] = 1, ["type"] = "item", ["image"] = "interseccion.png",["unique"] = false, ["useable"] = true, 	["shouldClose"] = true, 	["combinable"] = nil, ["ilegal"] = true, ["description"] = "Señal de tráfico."},
	["girou"] 				= {["name"] = "girou", 			["label"] = "Giro en U", 				["weight"] = 1, 		["type"] = "item", 		["image"] = "girou.png", 				["unique"] = false, 	["useable"] = true, 		["shouldClose"] = true, 	["combinable"] = nil, ["ilegal"] = true, ["description"] = "Señal de tráfico."},
	["noparking"] 			= {["name"] = "noparking", 		["label"] = "Señal de No Aparcar", 		["weight"] = 1, 		["type"] = "item", 		["image"] = "noparking.png", 			["unique"] = false, 	["useable"] = true, 		["shouldClose"] = true, 	["combinable"] = nil, ["ilegal"] = true, ["description"] = "Señal de tráfico."},
```

(Imagenes no incluidas)
