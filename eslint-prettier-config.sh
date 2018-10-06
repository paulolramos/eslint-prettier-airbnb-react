YELLOW='\033[1;33m'
GREEN='\033[1;32m'
LCYAN='\033[1;36m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting Style Formatting Configuration... ${NC}"

echo -e "1/4 ${LCYAN}Local ESLint & Prettier Installation... ${NC}"
yarn add -D eslint prettier

echo -e "2/4 ${YELLOW}Airbnb Configuration Installation... ${NC}"
npx install-peerdeps --dev eslint-config-airbnb

echo -e "3/4 ${LCYAN}Disabling ESLint Formatting... ${NC}"
yarn add -D eslint-config-prettier eslint-plugin-prettier

echo -e "4/4 ${YELLOW}Creating ESLint JSON... ${NC}"
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

echo -e "${GREEN}Done! ${NC}"

