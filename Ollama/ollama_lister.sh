#!/bin/bash

#  ┌──────────────────────────────────────────────────────────────────────────┐
#  │ ollama_lister.sh                                                         │  
#  │ Author:       Frederick Pellerin                                         │
#  │ X/GitHub:     @TheRealFredP3D                                            │
#  │ Date:         16-07-2024                                                 │
#  └──────────────────────────────────────────────────────────────────────────┘

# 1.Download the file`ollama_list.sh`
# 'https://github.com/TheRealFREDP3D/AI-4-FREE/blob/main/Ollama/ollama_lister.sh'

# 2. Make the file executable by running:
# `chmod +x ollama_lister.sh`

# 3. Run the script using:
#./ollama_list.sh

echo "┌──────────────────────────────────────────────────────────────────────────┐"
echo "│ ollama_lister.sh                                                         │"
echo "│ A tool designed to make life easier for people who frequently work       │"
echo "│ with multiple Ollama AI models, providing a quick and visually appealing │"
echo "│ way to view and manage their model list.                                 │"
echo "│ This script detect your active shell, check if the alias 'ollamal' exist.│"
echo "│ Of not, add it to your shell config file.                                │"
echo "└──────────────────────────────────────────────────────────────────────────┘"
echo ""
echo "┌──────────────────────────────────────────────────────────────────────────┐"
echo "│                            OLLAMA LAZY LISTER                            │"
echo "└──────────────────────────────────────────────────────────────────────────┘"
ollama list

echo ""
echo "****************************************************************************"
echo ""

echo "┌──────────────────────────────────────────────────────────────────────────┐"
echo "│                                 Full Name                                │"
echo "└──────────────────────────────────────────────────────────────────────────┘"
awk '{ print $1 }' <(ollama list)

echo ""
echo "****************************************************************************"
echo ""

echo "┌──────────────────────────────────────────────────────────────────────────┐"
echo "│                                 Short Name                                │"
echo "└──────────────────────────────────────────────────────────────────────────┘"
awk -F':' '{ print $1 }' <(ollama list)

echo ""
echo "****************************************************************************"
echo ""

# Detect the current shell
if [ -n "$ZSH_VERSION" ]; then
    config_file="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    config_file="$HOME/.bashrc"
else
    echo "Unsupported shell. Only Bash and Zsh are supported."
    exit 1
fi

# Define the alias you want to add
alias_to_add="alias ollamal='$PWD/ollama_lister.sh'"

# Check if the alias already exists in the config file
if grep -q "alias myalias=" "$config_file"; then
    # echo "Alias already exists in $config_file"
else
    # Add the alias to the config file
    echo "$alias_to_add" >> "$config_file"
    echo "Alias added to $config_file"
fi

# Remind the user to source the config file
echo "Remember to run 'source $config_file' to apply the changes in your current session."
