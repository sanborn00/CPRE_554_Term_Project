package com.example.cs554server

import io.netty.util.internal.ThreadLocalRandom
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.http.MediaType
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RestController
import reactor.core.publisher.Flux
import java.time.Duration
import java.time.LocalDateTime

@SpringBootApplication
class Cs554serverApplication

fun main(args: Array<String>) {
	runApplication<Cs554serverApplication>(*args)
}

@RestController
class RestController() {
	@GetMapping(value = ["/stocks/{symbol}"], produces = [MediaType.TEXT_EVENT_STREAM_VALUE])
	fun prices(@PathVariable symbol: String): Flux<StockPrice> {
		return Flux.interval(Duration.ofSeconds(1))
				.map { StockPrice(symbol, randomStockPrice(), LocalDateTime.now())
	}
}

data class StockPrice(val symbol: String,
					  val price: Double,
					  val time: LocalDateTime)

	private fun randomStockPrice(): Double {
		return ThreadLocalRandom.current().nextDouble(100.0)
	}
}