class AnalysisController < ApplicationController
  def index
    #load library and create new R session
    require "rinruby"

    #loading data is a pain because we can only move 1D vectors at a time
    R.eval "rm(userdata)"
    R.eval "userdata<-matrix()"
    R.eval "require(dplyr)"
    R.eval "require(gamlr)"
    R.eval "require(qpcR)"

    current_user.meals.each do |meal|
      tempmealingarray = meal.dishes.map(&:ingredients).flatten.sort_by(&:"name").pluck(:name)
      R.assign "newday", tempmealingarray
      R.eval "userdata<-qpcR:::cbind.na(userdata, newday)"
    end

    R.assign "feeling", current_user.meals.pluck(:mood)

R.eval <<EOF
    userdata<-userdata[,-1]
    userdata<-as.matrix(userdata)

    #make first row of ingredient counts
    one<-table(userdata[,1])
    k <- matrix(NA, nrow = 1, ncol = length(names(one)))
    colnames(k)<-names(one)
    k[1,]<-one

    #add all other rows
    for(i in 2:ncol(userdata)){
      two<-table(userdata[,i])
      m <- (matrix(NA, nrow = 1, ncol = length(names(two))))
      colnames(m)<-names(two)
      m[1,]<-two
      k<-dplyr::bind_rows(data.frame(k),data.frame(m))

    }

    #clean up a little
    # blanks<-which(colnames(k)==/"/")
    # k<-k[,-blanks]
     k[is.na(k)] <- 0

    #make model data and fit regression
    x <- k/rowSums(k)
    ing <- gamlr(x, feeling)
    results<-drop(coef(ing))

    #final output
    allerg<-sort(results, decreasing=TRUE)
    allerg<-allerg[-which(names(allerg)=="intercept")]
    allergens<-names(head(allerg[allerg>0],5))
    if(length(allergens)==0){allergens<-"Sorry, we need more data."}
EOF
    @allergies = R.pull "allergens"
    render("analysis/index.html.erb")
  end

end
