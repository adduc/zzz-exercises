package main

import (
	"testing"
)

func TestCounterLogic(t *testing.T) {
	// Test basic counter functionality
	counter := 0
	
	// Test increment
	counter++
	if counter != 1 {
		t.Errorf("Expected counter to be 1, got %d", counter)
	}
	
	// Test decrement
	counter--
	if counter != 0 {
		t.Errorf("Expected counter to be 0, got %d", counter)
	}
	
	// Test multiple increments
	for i := 0; i < 5; i++ {
		counter++
	}
	if counter != 5 {
		t.Errorf("Expected counter to be 5, got %d", counter)
	}
	
	// Test multiple decrements
	for i := 0; i < 3; i++ {
		counter--
	}
	if counter != 2 {
		t.Errorf("Expected counter to be 2, got %d", counter)
	}
	
	// Test negative numbers
	counter = 0
	counter--
	if counter != -1 {
		t.Errorf("Expected counter to be -1, got %d", counter)
	}
}