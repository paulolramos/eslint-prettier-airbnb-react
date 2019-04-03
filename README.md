# ESLint/Prettier & Airbnb's Style Guide for React Apps

**Make sure you `npm init`, or at least have a _package.json_ file before proceeding!**

## Installation
##### You will need _npm/npx_ installed. It will work on Windows, but just needs to be run in a bash shell, like VS Code's integrated terminal.

1. Navigate to your app directory where you want to include this style configuration.

    ```bash
    cd myApp
    ```

2. Run this command inside your app's root directory. Note: this command executes the `eslint-prettier-config.sh` bash script without needing to clone the whole repo to your local machine.

    ```bash
    exec 3<&1;bash <&3 <(curl https://raw.githubusercontent.com/paulolramos/eslint-prettier-airbnb-react/master/eslint-prettier-config.sh 2> /dev/null)
    ```

3. Look in your project's root directory and notice the two newly added/updated config files:
    - `.eslintrc.js` (or `.eslintrc.json`)
    - `.prettierrc`

This script follows this [tutorial](https://blog.echobind.com/integrating-prettier-eslint-airbnb-style-guide-in-vscode-47f07b5d7d6a) by Jeffrey Zhen.
