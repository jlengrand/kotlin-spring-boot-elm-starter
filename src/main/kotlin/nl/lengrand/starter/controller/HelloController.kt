package nl.lengrand.starter.controller

import nl.lengrand.starter.model.Hello
import org.springframework.web.bind.annotation.*

@RestController
class HelloController {

    @GetMapping("/hello")
    fun sayHello(@RequestParam(value = "name", defaultValue = "World") name: String) = Hello(name)

}