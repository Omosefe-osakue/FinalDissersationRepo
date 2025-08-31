import os
import sys
sys.path.insert(0, os.path.abspath('../code'))

project = 'SML Dissertation Project'
author = 'Omosefe Osakue'
release = '1.0'

extensions = []

templates_path = ['_templates']
exclude_patterns = []

html_theme = 'alabaster'

# Custom sidebar templates, must be a dictionary that maps document names to template names.
html_sidebars = {
    '**': [
        'about.html',
        'navigation.html',
        'relations.html',
        'searchbox.html',
    ]
}

# Theme options to customize the look and feel of the theme
html_theme_options = {
    'sidebar_collapse': False,
    'show_related': False
}

highlight_language = 'sml'
