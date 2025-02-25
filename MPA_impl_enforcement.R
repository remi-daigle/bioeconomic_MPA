#### Cost evaluation ####
# MPA implementation and enforcement
print("Now calculating: MPA implementation and enforcement")
fish_value_means$MPA_maintenance <- 0
fish_value$MPA_maintenance <- 0
for(scenario in protect_scen){
    for(rep in replicates){
        assign(paste(scenario), readOGR(dsn=paste0(results_folder,"/shapefiles"), layer = paste0(scenario,"_",rep)))
        assign(paste(scenario), spTransform(get(scenario),CRS(proj)))
        fish_value$MPA_maintenance[fish_value$scenario==scenario&fish_value$rep==rep] <- gArea(get(scenario))/10^6*MPA_maintenance_cost
    }
    fish_value_means$MPA_maintenance[fish_value_means$scenario==scenario] <- mean(fish_value$MPA_maintenance[fish_value$scenario==scenario])
}


fish_value$net_value <- fish_value$net_catch_value_USD-fish_value$MPA_maintenance
fish_value_means$net_value <- fish_value_means$net_catch_value_USD_mean-fish_value_means$MPA_maintenance

