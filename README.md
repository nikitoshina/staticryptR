# `staticryptR` --- add password to Quarto (qmd) and Rmarkdown (Rmd) html outputs

Protect your Quarto or R Markdown output—or any other HTML document—with `staticryptR`! 
> Safely encrypt and password protect the content of your public static HTML file, to be decrypted in-browser without any back-end - to serve it over static hosting like \[QuartoPub\], Netlify, GitHub pages, etc. (see a \[[live example](https://nikitoshina.quarto.pub/quarto_encryption/) password is "Password"\]). From the Packages documentation, my edits are in \[\].

Give the original [`staticrypt`](https://github.com/robinmoisson/staticrypt) package a star and check out its documentation for more details. `staticryptR` is a wrapper around this package, making it easier to use for R users.

To install `staticrypt` (it will be installed globally), you can either try running the `staticryptr()` function and respond with "yes" to the prompt, run `check_system()`, or use `install_staticrypt(force = TRUE)` to skip the confirmation prompt. 

To set it all up, you first need to have a `_quarto.yml` file. In it, you need to add a post-render script, and it's also recommended to specify an `output-dir`.

```yaml
# _quarto.yml
project:
  output-dir: "./_output"
  post-render: encrypt.r
```

Your `staticryptR` function will go into the `encrypt.r` file and will be executed after the document gets rendered, encrypting all the files!

The case you probably care about is encrypting your whole repository. You can do the following:

- Pass the folder's path to `files`.
- Set `recursive = TRUE`.
- Set `directory` to `"."`.

For password options, set `password = "yourverylongpassword"`. If you get an error that your password is too short, use `short = TRUE`.

So it would look something like this:

```r
# encrypt.r
staticryptr(
  files = "_output/",
  directory = ".",
  password = "yourverylongpassword",
  short = TRUE,
  recursive = TRUE
)
```

If you are encrypting a directory, you need to use `recursive = TRUE`, and `directory` should be `"."` so it replaces the files in your output directory. Notice that this is different from encrypting a single file, where you needed to specify the folder to output into. So if you wanted the files replaced, you would have to pass your output folder.

```r
# encrypt.r
staticryptr(
  files = c("path_to_file1", "path_to_file2"),
  directory = "path_to_output_folder",
  password = "yourverylongpassword",
  short = TRUE
)
```

If you want to encrypt multiple files, you have to pass them as a character vector.

I added all of the options from the package as parameters. This will help you get better completion and explore what is available from the documentation for the function. If you want to pass arguments not supported by the function or you just prefer passing everything as a string, there is the parameter `user_string`.

If you are just exploring what commands you get, you can use `print_cmd`.

You have to install Node.js and npm yourself. Luckily for you, it is trivial. Visit this page for instructions: [https://nodejs.org/en/download/package-manager](https://nodejs.org/en/download/package-manager).

There are many customization options. Either read the function documentation or, better yet, visit the `staticryptR` GitHub page and the documentation. All the functions concerning the appearance start with `template_`.

```r
staticryptr(
  files = "_output/",
  directory = ".",
  password = "yourverylongpassword",
  short = TRUE,
  recursive = TRUE,
  template_color_primary = "#6667AB",
  template_color_secondary = "#f9f9f3",
  template_title = "Your Document Title",
  template_instructions = "Enter the password or contact example@email.com",
  template_button = "Access"
)
```

By following these steps, you can easily encrypt your HTML files using `staticryptR`, providing an extra layer of security for your content. Happy encrypting!
