# The REPL
REPL stands for Read-Eval-Print-Loop. It is the interactive command-line interface to Julia. It reads expressions, evaluates them, prints the result, and loops back to the beginning. The REPL is a great way to experiment with Julia code and to learn the language.

After you installed Julia, you can start the REPL by typing `julia` in your command line.

The REPL behaves a bit different from what you might expect from Python. There are different prompt modes:

- `julia>`: This is the default prompt mode. You can type Julia code here and it will be executed.
- `help?>`: This is the help mode. You can type `?` followed by a function name to get help on that function. For example, typing `?println` will give you information about the `println` function.
- `pkg>`: This is the package mode. You can type `]` to enter this mode. Here you can manage your packages. For example, typing `add Example` will add the Example package to your environment.
- `shell>`: This is the shell mode. You can type `;` to enter this mode. Here you can run shell commands. For example, typing `;ls` will list the files in the current directory.
- `(reverse-i-search)`: This is the reverse search mode. You can type `Ctrl+R` to enter this mode. Here you can search through your command history.

You can return to the default prompt mode by pressing `Backspace`.
You can exit the REPL by typing `exit()` or pressing `Ctrl+D`.

## Project dependencies in Julia

Julia's virtual environment are stuctured very differently from python. In Julia, you can activate the current project by typing `]` to enter the package mode and then typing `activate .` to activate the current project. This will activate the project in the current directory.

A very usefull difference is the way virtual environments are handled. Instead of downloading the same package like `numpy` over and over again for every project you create (or, maybe giving up on virtual environments and installing everything globally), Julia uses a different approach.

All packages are stored in a central location on your computer; the `~/.julia` directory. The only thing the project has is a `Project.toml` file that specifies the dependencies of the project. This is just a text-file that determines which packages (stored in the central location) are needed for the project.

You can install all dependencies from the Project.toml file by
- first activating the project by typing `]` to enter package mode and then typing `activate .`
- installing the dependencies by typing `instantiate` in the package mode.

If you take a look at the contents of the Project.toml file, you can see all dependencies I installed for this project. Note this replaces the chaos of `pip install`, `requirements.txt`, `pyproject.toml`, poetry, pdm, rye, `setup.py`, etc. etc. etc. in Python. There is also a `Manifest.toml`, which is comparable to python implementations like `pip freeze`, `poetry.lock`, `conda list`, etc.

If you would want to add a new package to a project, eg the `DataFrames` package, you can do this by:
- activating the current project with `]` and then typing `activate .` (it can be deactivated by typing `activate` again, without the `.`)
- add the package by `add DataFrames` in pkg mode.
- you can check the current project by typing `st` or `status` in the pkg mode.
- exit the pkg mode by pressing `Backspace`
- you can type `;` to enter shell mode and type `ls` to see the `Project.toml` file, and even do `cat Project.toml` to print the contents of the file.