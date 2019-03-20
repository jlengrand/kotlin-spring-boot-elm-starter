package nl.lengrand.starter.model

import org.hamcrest.MatcherAssert.assertThat
import org.hamcrest.Matchers.equalToIgnoringCase
import org.junit.Test

class HelloTest {

    @Test
    fun testPrintName() {
        assertThat(Hello("world").toString(), equalToIgnoringCase("Hello world"))
    }
}