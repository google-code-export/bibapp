class SearchController < ApplicationController  
  def index
    if params[:q]
      # Default SolrRuby params
      @query        = params[:q] # User query
      @filter       = params[:fq] || ""
      @filter       = @filter.split("+>+").each{|f| f.strip!}
      @sort         = params[:sort] || "score"
      @page         = params[:page] || 0
      @facet_count  = params[:facet_count] || 50
      @rows         = params[:rows] || 10
      
      @q,@docs,@facets = Index.fetch(@query, @filter, @sort, @page, @facet_count, @rows)

      @spelling_suggestions = Index.get_spelling_suggestions(@query)

      @spelling_suggestions.each do |suggestion|
        # if suggestion matches query don't suggest...
        if suggestion.downcase == @query.downcase
          @spelling_suggestions.delete(suggestion)
        end
      end
    else
      @q = nil
      # There's nothing to return
    end
  end
end