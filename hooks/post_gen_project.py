'''
import subprocess

subprocess.call(['git', 'init'])
subprocess.call(['git', 'add', '.'])
subprocess.call(['git', 'commit', '-m', 'Initial commit'])

{% if cookiecutter.should_push_to_github == True %}
# create remote Github repository
subprocess.call(['gh', 'repo', 'create', '{{cookiecutter.github_repo}}'])

# add the remote Github repository and push it
subprocess.call(['git', 'remote', 'add', 'github', 'git@github.com:{{cookiecutter.github_user}}/{{cookiecutter.github_repo}}.git'])
subprocess.call(['git', 'push', '--set-upstream', 'origin', 'master'])
{% endif %}
'''
