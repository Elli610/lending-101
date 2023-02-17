//var HelloWorld=artifacts.require ("exerciceToken"); //solutionExercice
var HelloWorld=artifacts.require ("aaveUser");

module.exports = function(deployer) {
    deployer.deploy(HelloWorld);
    //deployer.deploy(HelloWorld);
};

