"repository";
git remote -v ;
""
"branch"
git branch | where {$_.startswith("*")};
git log --pretty=format:%h,%ae,%ad --date=short --since =1.month `
| convertfrom-csv -header hash, user, date `
| group date, user -NoElement `
| select `
    @{ Name="User"; Expression = { $_.Name.Split()[1].Trim(",")}}, `
    @{ Name="Date"; Expression = { $_.Name.Split()[0]}}, `
    Count `
| Sort User , Date;
cd 