TARGET_EXEC_SERVER = screen-worms-server
TARGET_EXEC_CLIENT = screen-worms-client

BUILD_DIR_SERVER = ./build_server
SRC_DIRS_SERVER = ./src/server ./src/shared_functionalities
BUILD_DIR_CLIENT = ./build_client
SRC_DIRS_CLIENT = ./src/client ./src/shared_functionalities

SRCS_SERVER := $(shell find $(SRC_DIRS_SERVER) -name *.cpp -or -name *.c)
OBJS_SERVER := $(SRCS:%=$(BUILD_DIR_SERVER)/%.o)
DEPS_SERVER := $(OBJS_SERVER:.o=.d)
SRCS_CLIENT := $(shell find $(SRC_DIRS_CLIENT) -name *.cpp -or -name *.c)
OBJS_CLIENT := $(SRCS:%=$(BUILD_DIR_CLIENT)/%.o)
DEPS_CLIENT := $(OBJS_CLIENT:.o=.d)

INC_DIRS := $(shell find $(SRC_DIRS) -type d)
INC_FLAGS := $(addprefix -I,$(INC_DIRS))

CC = gcc
CXX = g++

CPPFLAGS = $(INC_FLAGS) -MMD -MP
CFLAGS = -Wall -Wextra -std=c11
CXX_FLAGS = -Wall -Wextra -std=c++17

LIBS =

$(TARGET_EXEC_SERVER): $(OBJS_SERVER)
	$(CXX) $(OBJS) -o $@ $(LDFLAGS) $(LIBS)

# c source
$(BUILD_DIR_SERVER)/%.c.o: %.c
	$(MKDIR_P) $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

# c++ source
$(BUILD_DIR_SERVER)/%.cpp.o: %.cpp
	$(MKDIR_P) $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXX_FLAGS) -c $< -o $@ $(LIBS)

$(TARGET_EXEC_CLIENT): $(OBJS_CLIENT)
	$(CXX) $(OBJS) -o $@ $(LDFLAGS) $(LIBS)

# c source
$(BUILD_DIR_CLIENT)/%.c.o: %.c
	$(MKDIR_P) $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

# c++ source
$(BUILD_DIR_CLIENT)/%.cpp.o: %.cpp
	$(MKDIR_P) $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXX_FLAGS) -c $< -o $@ $(LIBS)


.PHONY: clean

clean:
	$(RM) -r $(BUILD_DIR_SERVER)
	$(RM) -r $(BUILD_DIR_CLIENT)
	rm screen-worms-server
	rm screen-worms-client

-include $(DEPS)

MKDIR_P = mkdir -p