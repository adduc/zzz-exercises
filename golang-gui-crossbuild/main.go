package main

import (
	"fmt"

	"fyne.io/fyne/v2"
	"fyne.io/fyne/v2/app"
	"fyne.io/fyne/v2/container"
	"fyne.io/fyne/v2/widget"
)

func main() {
	// Create a new application
	myApp := app.New()
	myApp.SetIcon(fyne.NewStaticResource("icon", []byte{}))

	// Create a new window
	myWindow := myApp.NewWindow("Counter App")
	myWindow.Resize(fyne.NewSize(300, 200))

	// Initialize counter
	counter := 0

	// Create the counter label
	counterLabel := widget.NewLabel(fmt.Sprintf("Counter: %d", counter))
	counterLabel.Alignment = fyne.TextAlignCenter

	// Create increment button
	incrementBtn := widget.NewButton("Increment (+)", func() {
		counter++
		counterLabel.SetText(fmt.Sprintf("Counter: %d", counter))
	})

	// Create decrement button
	decrementBtn := widget.NewButton("Decrement (-)", func() {
		counter--
		counterLabel.SetText(fmt.Sprintf("Counter: %d", counter))
	})

	// Create reset button for additional functionality
	resetBtn := widget.NewButton("Reset", func() {
		counter = 0
		counterLabel.SetText(fmt.Sprintf("Counter: %d", counter))
	})

	// Create button container
	buttonContainer := container.NewHBox(decrementBtn, resetBtn, incrementBtn)

	// Create main container
	content := container.NewVBox(
		widget.NewCard("", "", counterLabel),
		buttonContainer,
	)

	// Set the content and show the window
	myWindow.SetContent(content)
	myWindow.CenterOnScreen()
	myWindow.ShowAndRun()
}