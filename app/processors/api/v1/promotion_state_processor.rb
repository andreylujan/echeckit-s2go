class Api::V1::PromotionStateProcessor < JSONAPI::Processor
  after_find do
    unless @result.is_a?(JSONAPI::ErrorsOperationResult)
      # finished_reports = Report.where()
      promotion_states = PromotionState.all
      activated_promotions_count = promotion_states.where("activated_at is not null").count
      pending_promotions_count = promotion_states.count - activated_promotions_count
      @result.meta[:activated_promotions_count] = activated_promotions_count
      @result.meta[:pending_promotions_count] = pending_promotions_count
    end
  end
end
