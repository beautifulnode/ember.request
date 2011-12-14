var config = module.exports;

config["Ember.Request"] = {
    environment: "browser",        // or "node"
    sources: [
        "../js/jquery-1.7.min.js"
        , "../js/ember.js"
        ,"../js/**/*.js"   // Glob patterns supported
    ],
    tests: [
        "*-spec.js"
    ]
}
