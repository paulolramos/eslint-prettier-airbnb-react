#!/bin/bash

# ----------------------
# Color Variables
# ----------------------
RED="\033[0;31m"
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
LCYAN='\033[1;36m'
NC='\033[0m' # No Color

# ----------------------
# Perform Configuration
# ----------------------
echo
echo -e "${GREEN}Configuring your development environment... ${NC}"

echo
echo -e "1/5 ${LCYAN}ESLint & Prettier Installation... ${NC}"
echo
npm install -D eslint prettier

echo
echo -e "2/5 ${YELLOW}Conforming to Airbnb's JavaScript Style Guide... ${NC}"
echo
npm install -D eslint-config-airbnb eslint-plugin-jsx-a11y eslint-plugin-import eslint-plugin-react babel-eslint

echo
echo -e "3/5 ${LCYAN}Making ESlint and Prettier play nice with each other... ${NC}"
echo "See https://github.com/prettier/eslint-config-prettier for more details."
echo
npm install -D eslint-config-prettier eslint-plugin-prettier

  echo
  echo -e "4/5 ${YELLOW}Building your .eslintrc.json file...${NC}"
  > ".eslintrc.json" # truncates existing file (or creates empty)

  echo '{
  "extends": [
    "airbnb",
    "plugin:prettier/recommended",
    "prettier/react"
  ],
  "env": {
    "browser": true,
    "commonjs": true,
    "es6": true,
    "jest": true,
    "node": true
  },
  "rules": {
    "prettier/prettier": ["error", {
      "endOfLine":"auto"
    }],
    "jsx-a11y/href-no-hash": ["off"],
    "react/jsx-filename-extension": ["warn", { "extensions": [".js", ".jsx"] }],
    "max-len": [
      "warn",
      {
        "code": 80,
        "tabWidth": 2,
        "comments": 80,
        "ignoreComments": false,
        "ignoreTrailingComments": true,
        "ignoreUrls": true,
        "ignoreStrings": true,
        "ignoreTemplateLiterals": true,
        "ignoreRegExpLiterals": true
      }
    ]
  }
}' >> .eslintrc.json

  echo -e "5/5 ${YELLOW}Building your .prettierrc.json file... ${NC}"
  > .prettierrc.json # truncates existing file (or creates empty)

  echo '{ 
  "printWidth": 80,
  "singleQuote": true,
  "trailingComma": "none"
}' >> .prettierrc.json

echo
echo -e "${GREEN}Finished setting up!${NC}"
echo
