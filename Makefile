
SDL_CFLAGS = `sdl2-config --cflags`
SDL_LIBS = `sdl2-config --libs` -lSDL2_mixer -framework OpenGL -framework GLUT

#comment this line and uncomment the one below it to force detection
DEFINES:= -DAUTO_DETECT_PLATFORM -DBYPASS_PROTECTION
#DEFINES = -DSYS_LITTLE_ENDIAN

CXX = g++
CXXFLAGS:= -Os -g -std=gnu++98 -fno-rtti -fno-exceptions -Wall -Wno-unknown-pragmas -Wshadow
CXXFLAGS+= -Wundef -Wwrite-strings -Wnon-virtual-dtor -Wno-multichar
CXXFLAGS+= $(SDL_CFLAGS) $(DEFINES)

SRCS = bank.cpp file.cpp engine.cpp mixer.cpp resource.cpp parts.cpp vm.cpp \
	serializer.cpp sfxplayer.cpp staticres.cpp util.cpp video.cpp main.cpp sysImplementation.cpp

# logic.cpp sdlstub.cpp

OBJS = $(SRCS:.cpp=.o)
DEPS = $(SRCS:.cpp=.d)

game: $(OBJS)
	$(CXX) $(LDFLAGS) -o $@ $(OBJS) $(SDL_LIBS) -lz
	cp game ./build

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -MMD -c $< -o $*.o

clean:
	rm -f *.o *.d

-include $(DEPS)
