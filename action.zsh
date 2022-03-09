setopt bad_pattern {extended,ksh}_glob glob_{dots,star_short}

github=https://oauth:$GITHUB_TOKEN@$GITHUB_SERVER_URL:t
clone() git clone --single-branch ${=branch+--branch $branch} --depth 1 $github/$@

eval echo $source_files | read
source_files=($^=REPLY)

/bin/rm -r .git
clone ${${target_repo:h}/./$GITHUB_REPOSITORY_OWNER}/$target_repo:t ${=target_branch:+--branch $target_branch}

mkdir -p $target_repo:t/$target_path:r
rsync --recursive --relative --update $source_files $target_repo:t/$target_path
pushd $target_repo:t

: ${commit_message:=${(C)GITHUB_JOB//_/ } ${(j', ')source_files:t} from ${source_repo:-$GITHUB_REPOSITORY}}

git stage --all
git diff --staged --quiet && return
git commit --message $commit_message
git push origin ${target_branch:=${GITHUB_REF_NAME:-main}}
