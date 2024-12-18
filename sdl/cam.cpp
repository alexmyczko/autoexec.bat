#include <SDL.h>
#include <opencv2/opencv.hpp>
#include <stdio.h>

// g++ -std=c++11 -o cam cam.cpp $(pkg-config --cflags --libs opencv4) $(sdl2-config --cflags --libs)

using namespace cv;

Uint32 calculate_average_color(Mat frame) {
    long sum_r = 0, sum_g = 0, sum_b = 0;
    int total_pixels = frame.rows * frame.cols;

    // Iterate through pixels to calculate the average color
    for (int y = 0; y < frame.rows; ++y) {
        for (int x = 0; x < frame.cols; ++x) {
            Vec3b pixel = frame.at<Vec3b>(y, x); // BGR
            sum_b += pixel[0];
            sum_g += pixel[1];
            sum_r += pixel[2];
        }
    }

    // Average values
    Uint8 avg_r = sum_r / total_pixels;
    Uint8 avg_g = sum_g / total_pixels;
    Uint8 avg_b = sum_b / total_pixels;

    // Return packed color for SDL
    return (avg_r << 16) | (avg_g << 8) | avg_b;
}

int main(int argc, char* argv[]) {
    if (SDL_Init(SDL_INIT_VIDEO) != 0) {
        printf("SDL_Init Error: %s\n", SDL_GetError());
        return 1;
    }

    // Create SDL Window and Renderer
    SDL_Window* win = SDL_CreateWindow("Camera Average Color", 100, 100, 640, 480, SDL_WINDOW_SHOWN);
    SDL_Renderer* ren = SDL_CreateRenderer(win, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);

    if (!win || !ren) {
        printf("SDL_CreateWindow/Renderer Error: %s\n", SDL_GetError());
        SDL_Quit();
        return 1;
    }

    // Open camera with OpenCV
    VideoCapture cap(0);
    if (!cap.isOpened()) {
        printf("Error: Could not open camera.\n");
        return 1;
    }

    SDL_Event e;
    bool quit = false;
    bool fullscreen = false;
    int window_width = 640;
    int window_height = 480;

    while (!quit) {
        while (SDL_PollEvent(&e)) {
            if (e.type == SDL_QUIT) quit = true;
            if (e.type == SDL_KEYDOWN) {
                if (e.key.keysym.sym == SDLK_f) { // Toggle fullscreen on 'F' key press
                    fullscreen = !fullscreen;
                    if (fullscreen) {
                        SDL_SetWindowFullscreen(win, SDL_WINDOW_FULLSCREEN_DESKTOP);
                    } else {
                        SDL_SetWindowFullscreen(win, 0); // Disable fullscreen
                        SDL_SetWindowSize(win, window_width, window_height); // Restore window size
                    }
                }
            }
	    if (e.key.keysym.sym == SDLK_q) { // Exit on 'Q' key press
		quit = true;
	    }
        }

        // Grab a frame from the camera
        Mat frame;
        cap >> frame;
        if (frame.empty()) continue;

        // Get the center 50% of the frame
        int center_x = frame.cols / 2;
        int center_y = frame.rows / 2;
        int width = frame.cols / 2;
        int height = frame.rows / 2;

        Rect roi(center_x - width / 2, center_y - height / 2, width, height);
        Mat center_frame = frame(roi); // Crop to center 50%

        // Calculate average color
        Uint32 avg_color = calculate_average_color(center_frame);

        // Extract RGB components from the packed color
        Uint8 r = (avg_color >> 16) & 0xFF;
        Uint8 g = (avg_color >> 8) & 0xFF;
        Uint8 b = avg_color & 0xFF;

        // Clear the renderer with the average color
        SDL_SetRenderDrawColor(ren, r, g, b, 255);
        SDL_RenderClear(ren);
        SDL_RenderPresent(ren);
    }

    cap.release();
    SDL_DestroyRenderer(ren);
    SDL_DestroyWindow(win);
    SDL_Quit();

    return 0;
}
