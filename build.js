const fs = require("fs");
const path = require("path");
const { minify } = require("luamin");
const { log } = require("node:console")
const { bundle } = require("luabundle");

const entry = path.join(__dirname, "src", "main.lua");
const output = path.join(__dirname, "dist", "com.kiloo.subwaysurf.lua");

const colors = {
  reset: "\x1b[0m",
  bright: "\x1b[1m",
}

const bundleOptions = {
  minify: true,
  paths: [
    `src${path.sep}?.lua`,
  ],
};

if (!fs.existsSync(path.dirname(output)))
  fs.mkdirSync(path.dirname(output));

try {
  const luaBundle = bundle(entry, bundleOptions);

  fs.writeFile(output, luaBundle, (err) => {
    if (err) throw err;
    log(`${colors.bright}Bundle created!${colors.reset}`);
    log(`Size: ${fs.statSync(output).size} bytes`);
    log(`Output: ${output}`);
  })

  if (bundleOptions.minify) {
    const fileName = output.replace(".lua", ".min.lua");
    fs.writeFile(fileName, minify(luaBundle), (err) => {
      if (err) throw err;
      log(`${colors.bright}Minified bundle created!${colors.reset}`);
      log(`Size: ${fs.statSync(fileName).size} bytes`);
      log(`Output: ${fileName}`);
    })
  }

} catch (err) {
  console.error(err);
}

