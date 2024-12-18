#include <SDL.h>
#include <stdbool.h>
#include <math.h>

// gcc -o strobe strobe.c $(sdl2-config --cflags --libs) -lm

// Function to calculate RGB values for a rainbow color based on a position (0-1)
void getRainbowColor(float position, Uint8 *r, Uint8 *g, Uint8 *b) {
    // Ensure position is wrapped between 0 and 1
    position = fmod(position, 1.0f);

    // Calculate the color based on the position
    float normalizedPosition = position * 6.0f; // Six color segments
    int segment = (int)floor(normalizedPosition);
    float t = normalizedPosition - segment;

    switch (segment) {
        case 0: *r = 255; *g = (Uint8)(t * 255); *b = 0; break;           // Red to Yellow
        case 1: *r = (Uint8)((1 - t) * 255); *g = 255; *b = 0; break;    // Yellow to Green
        case 2: *r = 0; *g = 255; *b = (Uint8)(t * 255); break;          // Green to Cyan
        case 3: *r = 0; *g = (Uint8)((1 - t) * 255); *b = 255; break;    // Cyan to Blue
        case 4: *r = (Uint8)(t * 255); *g = 0; *b = 255; break;          // Blue to Magenta
        case 5: *r = 255; *g = 0; *b = (Uint8)((1 - t) * 255); break;    // Magenta to Red
    }
}

int main(int argc, char *argv[]) {
    bool fullscreen = false;
    int window_width = 640;
    int window_height = 480;

    // Initialize SDL
    if (SDL_Init(SDL_INIT_VIDEO) != 0) {
        SDL_Log("Unable to initialize SDL: %s", SDL_GetError());
        return 1;
    }

    //SDL_Window* win = SDL_CreateWindow("Camera Average Color", 100, 100, 640, 480, SDL_WINDOW_SHOWN);
    // Create a fullscreen window
    SDL_Window *window = SDL_CreateWindow(
        "Stroboscope",
        SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
        640, 480, // Resolution (ignored in fullscreen)
        SDL_WINDOW_SHOWN
        //SDL_WINDOW_FULLSCREEN | SDL_WINDOW_SHOWN
    );

    if (!window) {
        SDL_Log("Could not create window: %s", SDL_GetError());
        SDL_Quit();
        return 1;
    }

    // Create a renderer with vsync to avoid tearing
    SDL_Renderer *renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
    if (!renderer) {
        SDL_Log("Could not create renderer: %s", SDL_GetError());
        SDL_DestroyWindow(window);
        SDL_Quit();
        return 1;
    }

    // Variables for the strobe effect
    bool isWhite = true;          // Toggle between active colors and black
    bool running = true;          // Program running flag
    bool useRainbow = false;      // White mode or Rainbow mode
    SDL_Event event;
    int delay = 30;               // Initial delay in milliseconds
    float rainbowPosition = 0.0f; // Initial rainbow position
    Uint8 r, g, b;                // Color values

    // Main loop
    while (running) {
        // Poll for events
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT || (event.type == SDL_KEYDOWN && event.key.keysym.sym == SDLK_ESCAPE)) {
                running = false; // Exit the loop
            }

            // Adjust delay with + and - keys
            if (event.type == SDL_KEYDOWN) {
                if (event.key.keysym.sym == SDLK_PLUS || event.key.keysym.sym == SDLK_EQUALS) {
                    delay = (delay > 1) ? delay - 1 : 1; // Decrease delay, but not below 1ms
                } else if (event.key.keysym.sym == SDLK_MINUS || event.key.keysym.sym == SDLK_UNDERSCORE) {
                    delay += 1; // Increase delay
                }

                // Toggle between white and rainbow mode with the 'C' key
                if (event.key.keysym.sym == SDLK_c) {
                    useRainbow = !useRainbow;
                }
                if (event.key.keysym.sym == SDLK_f) { // Toggle fullscreen on 'F' key press
                    fullscreen = !fullscreen;
                    if (fullscreen) {
                        SDL_SetWindowFullscreen(window, SDL_WINDOW_FULLSCREEN_DESKTOP);
                    } else {
                        SDL_SetWindowFullscreen(window, 0); // Disable fullscreen
                        SDL_SetWindowSize(window, window_width, window_height); // Restore window size
                    }
                }
            }
        }

        // Set the active color
        if (isWhite) {
            if (useRainbow) {
                getRainbowColor(rainbowPosition, &r, &g, &b); // Get next rainbow color
                SDL_SetRenderDrawColor(renderer, r, g, b, 255);
                rainbowPosition += (delay*0.0002f); // Increment position for smooth rainbow transition
            } else {
                SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255); // White
            }
        } else {
    	    if (!useRainbow) {
        	SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255); // Black
            }
        }
        isWhite = !isWhite;

        // Clear the screen with the current color
        SDL_RenderClear(renderer);

        // Present the frame
        SDL_RenderPresent(renderer);

        // Control strobe speed
        SDL_Delay(delay);
    }

    // Cleanup
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();

    return 0;
}
