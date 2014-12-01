def clear():
    """Clears the shell of the spyder application.
    use either clear() or cls()"""
    os.system('cls')
    return None
cls = clear

def clear_all():
    """Clears all the variables from the workspace of the spyder
    application."""
    cls()
    gl = globals().copy()
    for var in gl:
        if var[0] == '_': continue
        if 'func' in str(globals()[var]): continue
        if 'module' in str(globals()[var]): continue

        del globals()[var]