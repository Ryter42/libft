# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: emoreau <emoreau@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/03/02 19:52:26 by kbouzegh          #+#    #+#              #
#    Updated: 2023/03/24 23:47:36 by emoreau          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Répertoires
SRC_DIR := srcs
OBJ_DIR := obj
BIN_DIR := .
LIB_DIR := Printf/

# Fichiers sources
SRC_FILES := $(wildcard $(SRC_DIR)/*.c)

# Fichiers objets
OBJ_FILES = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRC_FILES))

# Compilateur et options
CC := gcc
CFLAGS := -Wall -Wextra -Werror
LDFLAGS := -I ${LIB_DIR} -I ./

# Nom de l'exécutable
TARGET := libft.a

all : ${TARGET}

# Règle pour générer l'exécutable
$(TARGET): $(OBJ_FILES)
	cd Printf && make && cd ..
	ar rc ${TARGET} $(OBJ_FILES)
	ranlib $(TARGET)

# Règle pour générer les fichiers objets
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) ${LDFLAGS} -c $< && mv *.o ${OBJ_DIR}

# Règle pour nettoyer les fichiers objets et l'exécutable
clean:
	rm -rf $(OBJ_DIR)/*.o $(TARGET) && cd Printf && make clean && cd ..

fclean : clean
	rm -f $(TARGET) && cd Printf && make fclean && cd ..

re : fclean all