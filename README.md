# 自动删除PR Merge后的分支

这个 action 是用来自动已Merge的分支进行删除的

## 约定条件

#### 分支 命名规范
格式：pr_${BRANCH_TO}_other
说明：分支必须以 pr_开头，后面是向 某个分支发起的PR请求分支, 最后是其他名字

## Inputs
无

## Example usage

```yaml
on:
  pull_request:
    types: [closed]


name: Auto delete the PR branch if need

jobs:
  delete_pr_branch:
    name: Auto delete the PR branch
    runs-on: ubuntu-latest
    steps:
      - name: Auto delete the PR branch
        uses: jumpserver/action-auto-del-pr-branch@master
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```
