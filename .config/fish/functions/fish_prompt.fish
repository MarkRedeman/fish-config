function fish_prompt
  set -l code $status
  prompt_status
  # prompt_context
  prompt_dir

  if git_is_repo
    prompt_git
  end

  prompt_end
end

function prompt_status
  if [ $status -ne 0 ]
    set_color red
    echo -n "✘ "
  end

  # if superuser (uid == 0)
  set -l uid (id -u $USER)
  if [ (id -u $USER) -eq 0 ]
    set_color yellow
    echo -n "⚡ "
  end

  # # Jobs display
  # if [ (jobs -l | wc -l) -gt 0 ]
  #   set_color cyan
  #   echo -n "⚙ "
  # end

  set_color normal
end



function prompt_dir
  set -l current_dir (command pwd)

  set_color blue
  if git_is_repo
      set -l repo_root (git rev-parse --show-toplevel)
      set -l repo_name (basename $repo_root)

      # Remove any paths before the repo_root path
      echo -n $current_dir | sed -e "s#^$repo_root#$repo_name#"
    else
      # If in home, show ~ instead of $HOME
      echo -n $current_dir | sed -e "s#^$HOME#~#"
  end
  set_color normal
end

function prompt_git
  if git_is_touched
    set_color yellow
  end
  echo -n "  "(git_branch_name)""
  if git_is_dirty
    echo -n " ✗"
  end
  prompt_git_modes

  set_color normal
end

function prompt_git_modes
  set -l git_dir (command git rev-parse --git-dir ^/dev/null)

  prompt_bisecting $git_dir
  prompt_merging   $git_dir
  prompt_rebasing  $git_dir

  set_color normal
end

function prompt_bisecting --description "prompt_bisecting <git_dir>: If in bisecting mode, displays [BISECTING]"
  set -l git_dir $argv[1]
  set -l check_bisect "$git_dir/BISECT_LOG"

  if test -e $check_bisect
    set_color green
    echo -n " [BISECTING]"
  end
end

function prompt_merging --description "prompt_merging <git_dir>: If in merge conflict mode, displays [MERGING]"
  set -l git_dir $argv[1]
  set -l check_merge "$git_dir/MERGING"

  if test -e $check_merge
    set_color red
    echo -n " [MERGING]"
  end
end

function prompt_rebasing --description "prompt_rebasing <git_dir>: If in rebase conflict mode, displays [REBASING]"
  set -l git_dir $argv[1]
  set -l check_rebase "$git_dir/rebase"

  if test -e $check_rebase
    set_color red
    echo -n " [REBASING]"
  end
end

function prompt_end
  echo -n " "
end
