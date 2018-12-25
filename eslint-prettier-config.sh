#!/bin/bash

YELLOW='\033[1;33m'
GREEN='\033[1;32m'
LCYAN='\033[1;36m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting Style Formatting Configuration... ${NC}"

echo -e "1/5 ${LCYAN}Local ESLint & Prettier Installation... ${NC}"
yarn add -D eslint prettier

echo -e "2/5 ${YELLOW}Airbnb Configuration Installation... ${NC}"
yarn add -D eslint-config-airbnb eslint-plugin-jsx-a11y eslint-plugin-import eslint-plugin-react babel-eslint

echo -e "3/5 ${LCYAN}Disabling ESLint Formatting... ${NC}"
yarn add -D eslint-config-prettier eslint-plugin-prettier eslint-plugin-flowtype eslint-config-react-app

echo -e "4/5 ${YELLOW}Creating ESLint JSON... ${NC}"
touch .eslintrc.json

echo '{
  "extends": ["airbnb", "prettier", "react-app", "plugin:prettier/recommended"],
  "plugins": ["prettier"],
  "rules": {
    "prettier/prettier": ["error"],
    "jsx-a11y/href-no-hash": [0],
    "react/jsx-filename-extension": [1, { "extensions": [".js", ".jsx"] }]
  }
}' >> .eslintrc.json

echo -e "5/5 ${YELLOW}Creating Custom Prettier Config... ${NC}"
touch .prettierrc

echo '{
  "printWidth": 100,
  "singleQuote": true
}' >> .prettierrc

echo -e "${GREEN}Done! ${NC}"

