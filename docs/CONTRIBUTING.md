# Contribution Guide
Hi, First of all thanks for wanting to contribute to this project! You'll find some general guidelines concerning behaviour on this project in the "Code of Conduct.md" File in the root directory of the project. 

Basically it encourages you to be a nice person while here, but that should be clear.

## Guidline for contribution

### Issues

* Please create an issue for your submission.

### Branches

* **Master branch** 
  * Do not work directly on the Master branch.
  * The Master branch is updated via the Dev branch (Merge).
* ** Fork **
  * So basically just fork the project, clone it and make a branch.
  * then submit a Pull Request to the Dev branch.
* **Your own branch**
  * Before you create your branch create an issue for what you want to do.
  * Respect the naming convention for your branch.
    * Name your branch in the following pattern : [Projectname][IssueID] --> [PowershellProject][#1234]
    
### Testing

* **Tests**
  * Write the Tests for the code you write and also commit them. Make sure all your code is tested.
  * Pull requests with unsufficient tests will be rejected.
* **Unit Testing**
  * Once you've writen your tests, please make sure they succeed with the newest version of [Pester](https://github.com/pester/Pester) before you create your pull request.
  * Once your tests succeed, push your branch. If the Build on your branch succeeds you can submit your Pullrequest. Please see our [Pullrequest Template](Docs/PULL_REQUEST_TEMPLATE.md).  
  
