#!/bin/bash

YELLOW='\033[1;33m'
GREEN='\033[1;32m'
LCYAN='\033[1;36m'
NC='\033[0m' # No Color

# Prompt for config preferences
# -----------------------------
echo
echo "????? Which package manager are you using?"
select package_command_choices in "Yarn" "npm" "Cancel"; do
  case $package_command_choices in
    Yarn ) pkg_cmd='yarn add'; break;;
    npm ) pkg_cmd='npm install'; break;;
    Cancel ) exit;;
  esac
done
echo

echo "????? Which ESLint configuration format do you perfer?"
select eslint_config_extension in ".js" ".json" "Cancel"; do
  case $eslint_config_extension in
    .js ) config_opening='module.exports = {'; break;;
    .json ) config_opening='{'; break;;
    Cancel ) exit;;
  esac
done
echo

if [ -f ".eslintrc.js" -o -f ".eslintrc.yaml" -o -f ".eslintrc.yml" -o -f ".eslintrc.json" -o -f ".eslintrc" ]; then
  echo "!!!!! Existing ESLint config file(s) found:"
  ls -a .eslint* | xargs -n 1 basename
  echo
  echo ">>>> CAUTION: there is loading priority when more than one config file is present: https://eslint.org/docs/user-guide/configuring#configuration-file-formats"
  echo
  read -p  "????? Write .eslintrc${eslint_config_extension} (Y/n)? "
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo ">>>>> Skipping ESLint config"
    skip_eslint_setup="true"
  fi
fi

finished=false
while ! $finished; do
  echo
  read -p "????? What max line length do you want to set for ESLint and Prettier (Recommendations: 80 or 100 or 120)? "
  if [[ $REPLY =~ ^[0-9]{2,3}$ ]]; then
    max_len_val=$REPLY
    finished=true
    echo
  else
    echo "!!!!! Please choose a max length of two or three digits, e.g. 80 or 100 or 120"
  fi
done

echo "????? What style of trailing commas do you want to enforce with prettier?"
echo ">>>>> See https://prettier.io/docs/en/options.html#trailing-commas for more details."
select trailing_comma_pref in "none" "es5" "all"; do
  case $trailing_comma_pref in
    none ) break;;
    es5 ) break;;
    all ) break;;
  esac
done
echo

if [ -f ".prettierrc" ]; then
  echo "!!!!! Existing .prettierrc config file found"
  read -p "????? Overwrite existing Prettier config file (Y/n)? "
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo ">>>>> Skipping Prettier config"
    skip_prettier_setup="true"
  fi
  echo
fi


# Pefrom config
# -------------
echo
echo -e "${GREEN}Starting Style Formatting Configuration... ${NC}"

echo
echo -e "1/5 ${LCYAN}Local ESLint & Prettier Installation... ${NC}"
echo
$pkg_cmd -D eslint prettier


echo
echo
echo -e "2/5 ${YELLOW}Airbnb Configuration Installation... ${NC}"
echo
$pkg_cmd -D eslint-config-airbnb eslint-plugin-jsx-a11y eslint-plugin-import eslint-plugin-react babel-eslint


echo
echo
echo -e "3/5 ${LCYAN}Disabling ESLint Formatting... ${NC}"
echo "See  for more details."
echo
$pkg_cmd -D eslint-config-prettier eslint-plugin-prettier eslint-plugin-flowtype eslint-config-react-app


if [ "$skip_eslint_setup" == "true" ]; then
  break
else
  echo
  echo
  echo -e "4/5 ${YELLOW}Creating custom .eslintrc${eslint_config_extension} config...${GREEN}Done! ${NC}"
  > ".eslintrc${eslint_config_extension}" # truncates existing file (or creates empty)

  echo ${config_opening}'
  "extends": ["airbnb", "prettier", "react-app", "plugin:prettier/recommended"],
  "plugins": ["prettier"],
  "rules": {
    "prettier/prettier": ["error"],
    //https://github.com/evcohen/eslint-plugin-jsx-a11y/issues/397#issuecomment-393921950
    "jsx-a11y/href-no-hash": [0],
    "react/jsx-filename-extension": [1, { "extensions": [".js", ".jsx"] }],
    "max-len": [
      "error",
      {
        "code": '${max_len_val}',
        "tabWidth": 2,
        "comments": '${max_len_val}',
        "ignoreUrls": true,
        "ignoreComments": false,
        "ignoreTrailingComments": true,
        "ignoreUrls": true,
        "ignoreStrings": true,
        "ignoreTemplateLiterals": true,
        "ignoreRegExpLiterals": true
      }
    ]
  }
}' >> .eslintrc${eslint_config_extension}
fi


if [ "$skip_prettier_setup" == "true" ]; then
  break
else
  echo -e "5/5 ${YELLOW}Creating custom .prettierrc config...${GREEN}Done! ${NC}"
  > .prettierrc # truncates existing file (or creates empty)

  echo '{
  "printWidth": '${max_len_val}',
  "singleQuote": true,
  "trailingComma": '${trailing_comma_pref}'
}' >> .prettierrc
fi

echo
echo -e "${GREEN}Finished Style Formatting Configuration! ${NC}"
echo
